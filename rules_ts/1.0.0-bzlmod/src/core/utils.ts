import _ from "lodash";
import { v4 as uuidv4 } from "uuid";
import { format, isPast } from "date-fns";
import type { User, Task } from "./types";

export function createUser(name: string, email: string): User {
    return {
        id: uuidv4(),
        name,
        email,
        role: "member",
        createdAt: new Date(),
    };
}

export function createTask(title: string, assigneeId?: string): Task {
    return {
        id: uuidv4(),
        title,
        assigneeId,
        status: "todo",
        createdAt: new Date(),
    };
}

export function isOverdue(task: Task): boolean {
    return !!task.dueDate && task.status !== "done" && isPast(task.dueDate);
}

export function formatDate(date: Date): string {
    return format(date, "yyyy-MM-dd HH:mm:ss");
}

export function groupByStatus(tasks: Task[]): Record<string, Task[]> {
    return _.groupBy(tasks, "status");
}
