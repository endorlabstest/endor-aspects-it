import express, { Request, Response } from "express";
import { createUser, createTask, formatDate, groupByStatus } from "../core/utils";
import { UserSchema, TaskSchema } from "../core/types";

// Scoped @babel — AST parsing for code analysis endpoint
import { parse } from "@babel/parser";

// Scoped @opentelemetry — request tracing
import { trace, SpanStatusCode } from "@opentelemetry/api";

// Scoped @sinclair — alternative schema validation
import { Type, Static } from "@sinclair/typebox";

// Scoped @hapi — HTTP error creation
import Boom from "@hapi/boom";

// Scoped @fastify — typed error constructors
import FastifyError from "@fastify/error";

// Scoped @koa — alternative router
const KoaRouter: any = require("@koa/router");

// npm alias — resolved package name differs from alias name
const stringWidth: (s: string) => number = require("string-width-cjs");

// Native binary — platform-specific optional deps
import * as esbuild from "esbuild";

// Exact pinned version
import { fetch } from "undici";

// @sinclair/typebox schema
const HealthResponse = Type.Object({
    status: Type.String(),
    timestamp: Type.String(),
    uptime: Type.Number(),
});
type HealthResponse = Static<typeof HealthResponse>;

// @fastify/error typed errors
const NotFoundError = FastifyError("ERR_NOT_FOUND", "%s not found", 404);
const ValidationError = FastifyError("ERR_VALIDATION", "Validation: %s", 422);

const tracer = trace.getTracer("api-server", "1.0.0");

export function createApp(): express.Application {
    const app = express();
    app.use(express.json());

    app.get("/health", (_req: Request, res: Response) => {
        const span = tracer.startSpan("health-check");
        const health: HealthResponse = {
            status: "ok",
            timestamp: formatDate(new Date()),
            uptime: process.uptime(),
        };
        span.setStatus({ code: SpanStatusCode.OK });
        span.end();
        res.json(health);
    });

    app.post("/users", (req: Request, res: Response) => {
        const span = tracer.startSpan("create-user");
        try {
            const { name, email } = req.body;
            const user = createUser(name, email);
            const parsed = UserSchema.safeParse(user);
            if (!parsed.success) {
                throw new ValidationError(parsed.error.issues[0]?.message ?? "invalid");
            }
            span.setStatus({ code: SpanStatusCode.OK });
            res.status(201).json(parsed.data);
        } catch (err) {
            span.setStatus({ code: SpanStatusCode.ERROR, message: String(err) });
            if (err instanceof Error && "statusCode" in err) {
                res.status((err as any).statusCode).json({ error: err.message });
            } else {
                res.status(500).json({ error: "internal error" });
            }
        } finally {
            span.end();
        }
    });

    app.post("/tasks", (req: Request, res: Response) => {
        const { title, assigneeId } = req.body;
        const task = createTask(title, assigneeId);
        const parsed = TaskSchema.safeParse(task);
        if (!parsed.success) {
            const boom = Boom.badRequest(parsed.error.issues[0]?.message);
            res.status(boom.output.statusCode).json(boom.output.payload);
            return;
        }
        res.status(201).json(parsed.data);
    });

    // @babel/parser — parse TypeScript code and extract imports
    app.post("/analyze", (req: Request, res: Response) => {
        const { code } = req.body;
        if (typeof code !== "string") {
            throw new NotFoundError("code body");
        }
        const ast = parse(code, { sourceType: "module", plugins: ["typescript"] });
        const imports = ast.program.body
            .filter((n): n is Extract<typeof n, { type: "ImportDeclaration" }> => n.type === "ImportDeclaration")
            .map((n) => n.source.value);
        res.json({ imports });
    });

    // npm alias (string-width-cjs) — measure display width
    app.get("/width", (req: Request, res: Response) => {
        const text = String(req.query.text ?? "");
        res.json({ text, displayWidth: stringWidth(text) });
    });

    // esbuild — bundle analysis
    app.post("/bundle-analyze", async (req: Request, res: Response) => {
        const { code } = req.body;
        const result = await esbuild.transform(String(code ?? ""), {
            loader: "ts",
            minify: true,
        });
        res.json({ minified: result.code, originalLength: String(code).length, minifiedLength: result.code.length });
    });

    // undici (exact pinned) — proxy fetch
    app.get("/proxy", async (req: Request, res: Response) => {
        const url = String(req.query.url ?? "");
        if (!url) {
            res.status(400).json({ error: "url required" });
            return;
        }
        const upstream = await fetch(url);
        const data = await upstream.text();
        res.json({ status: upstream.status, length: data.length });
    });

    // @koa/router — expose koa routes config
    app.get("/koa-routes", (_req: Request, res: Response) => {
        const router = new KoaRouter({ prefix: "/api" });
        router.get("/ping", () => {});
        router.post("/echo", () => {});
        res.json({ routes: router.stack.map((r: any) => ({ path: r.path, methods: r.methods })) });
    });

    return app;
}
