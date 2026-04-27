import { z } from "zod";

export const UserSchema = z.object({
    id: z.string().uuid(),
    name: z.string().min(1).max(100),
    email: z.string().email(),
    role: z.enum(["admin", "member", "viewer"]).default("member"),
    createdAt: z.date(),
});

export type User = z.infer<typeof UserSchema>;

export const TaskSchema = z.object({
    id: z.string().uuid(),
    title: z.string().min(1).max(200),
    assigneeId: z.string().uuid().optional(),
    status: z.enum(["todo", "in_progress", "done"]),
    dueDate: z.date().optional(),
    createdAt: z.date(),
});

export type Task = z.infer<typeof TaskSchema>;
