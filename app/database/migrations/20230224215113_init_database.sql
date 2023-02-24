-- +goose Up
-- +goose StatementBegin
CREATE TABLE "users" (
    "id" BIGSERIAL NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "deleted_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");

CREATE TABLE "task_types" (
    "id" BIGSERIAL NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "display_name" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "deleted_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "task_types" ADD PRIMARY KEY("id");

INSERT INTO "task_types" (type, display_name, created_at) VALUES ('formally', 'Formally', CURRENT_TIMESTAMP(0));
INSERT INTO "task_types" (type, display_name, created_at) VALUES ('not_necessary', 'Not necessary', CURRENT_TIMESTAMP(0));
INSERT INTO "task_types" (type, display_name, created_at) VALUES ('important', 'Important', CURRENT_TIMESTAMP(0));

CREATE TABLE "tasks" (
    "id" BIGSERIAL NOT NULL,
    "topic" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "is_completed" BOOLEAN NOT NULL,
    "task_type_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "due_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "deleted_at" TIMESTAMP(0) WITHOUT TIME ZONE NULL
);
ALTER TABLE
    "tasks" ADD PRIMARY KEY("id");
ALTER TABLE
    "tasks" ADD CONSTRAINT "tasks_task_type_id_foreign" FOREIGN KEY("task_type_id") REFERENCES "task_types"("id");
ALTER TABLE
    "tasks" ADD CONSTRAINT "tasks_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
