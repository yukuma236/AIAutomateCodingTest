# Project Development Instructions

## Shared Development Standards

This project uses development standards located in the `standards/` directory.

`standards/` is a Git submodule that references the
[power-automate-standards](https://github.com/yukuma236/power-automate-standards) repository,
pinned to a specific tagged release (see `README.md` for the current pinned version).
If `standards/` appears empty or stale, run `./scripts/update-standards.ps1`
(or `git submodule update --init --recursive`) before relying on it.

Use `standards/docs/README.md` as the entry point for development standards.

Do not load all development-standard documents by default.

Do not scan or load all files under `standards/`.

First inspect the standard index, then load only the documents relevant to the current task.

For each task:

1. Identify the type and scope of the task.
2. Inspect the project-specific information under `docs/`.
3. Identify only the development-standard documents under `standards/docs/` that are relevant to the task.
4. Read and apply those relevant standards before planning or implementing changes.
5. Do not silently ignore or override a development standard.

Do not assume requirements, architecture, or implementation decisions from other projects apply to this repository.

## Priority

Use the following priority when making implementation decisions:

1. Explicit project requirements and architectural decisions under `docs/`
2. Development standards under `standards/docs/`
3. Existing implementation samples under `standards/samples/flows/` (see "New Flow Creation" below)
4. Existing implementation patterns in this project
5. General Power Platform best practices

If project requirements conflict with the development standards, explicitly identify the conflict before implementation.

## Standards Directory

Files under `standards/` are development standards shared within this project.

Do not modify files under `standards/` as part of normal flow implementation work.

If project work reveals that a standard is incorrect, ambiguous, incomplete, or impractical, report it as a development-standard improvement candidate.

## Development Workflow

For non-trivial development tasks, use the following workflow in order:

1. Research
2. Plan
3. Implement and Validate

Use the corresponding reusable prompt files under `.github/prompts/` for each phase unless the user explicitly requests a different workflow.

For non-trivial development tasks, do not begin implementation before completing the Research and Plan phases.

## Power Automate Cloud Flows Source of Truth

Power Platform (the target environment) is the authoritative source for the current cloud flow definition.

The `src/flows/` directory contains a local JSON representation of flow definitions, exported via the FlowAgent MCP server, used for AI-assisted development, analysis, source control, and review.

Do not assume that files under `src/flows/` represent the current Power Platform state unless synchronization has been successfully completed.

### Research

Before researching the current implementation of an existing cloud flow, use the FlowAgent MCP server (`get_flow`) to retrieve the current flow definition from the target environment and update `src/flows/`.

Research the synchronized definition under `src/flows/` together with project requirements under `docs/` and the applicable development standards under `standards/docs/`.

During the Research phase, use FlowAgent MCP only as necessary to obtain or inspect the current implementation state (e.g. `get_flow`, `list_flows`, `get_run_history`, `get_run_actions`, `diagnose_run`).

Do not modify the flow during the Research phase.

If synchronization cannot be completed, explicitly report that the current implementation state could not be verified. Do not silently rely on potentially stale files under `src/flows/`.

### New Flow Creation

Before designing a brand-new cloud flow, check `standards/docs/power_automate_dev_standard.md` section
"8. 実装パターン集" (implementation pattern index) and `standards/samples/flows/` for an existing sample
that matches or resembles the requirement (e.g. approval reminders, retention-based cleanup, upsert patterns,
SharePoint REST calls, self-health checks, Teams mention notifications, polling with synchronous response,
AI Builder document processing).

If a matching or closely related sample exists, use it as the baseline implementation pattern (action
structure, error handling, naming) rather than designing the flow from scratch. Still adapt it to the
project-specific requirements under `docs/` and this project's connections/environment.

If no matching sample exists, proceed with standard design, and after implementation is validated, report
to the user that this may be a new reusable pattern worth proposing back to `power-automate-standards`
(`standards/samples/`), without modifying the submodule content directly from this project.

### Implementation

Before implementing changes to an existing cloud flow, retrieve the current flow definition via FlowAgent MCP (`get_flow`) again to ensure that implementation is based on the latest Power Platform state.

When implementing changes to a cloud flow, use the available Power Automate skills (`create-flow`, `build-flow`, `debug-flow`, `manage-flows`) and FlowAgent MCP tools (`create_flow`, `update_flow`, `edit_flow`, `preflight_flow`, `validate_flow`) rather than treating the exported JSON as an ordinary source file to hand-edit and re-upload wholesale.

Use `src/flows/` as the project-standard location for local flow definition exports.

If the required FlowAgent MCP tools or synchronization are unavailable, report the limitation and do not make flow implementation changes.

After implementation, validate the resulting flow and confirm that the local export under `src/flows/` is synchronized with the resulting Power Platform state.

Prefer non-production (Developer / Sandbox) environments for implementation and validation unless the project has explicitly decided to work directly in Production.

## Solution Management

FlowAgent MCP does not currently support adding a flow to a Dataverse solution directly. When a flow needs to be deployed via a solution (per `standards/docs/solution-management-standard.md`), create or edit the flow using FlowAgent MCP first, then report to the user that the flow still needs to be added to the target solution via the maker portal (or `pac solution add-reference`) before it can be exported and promoted through `solutions/`.

Do not fabricate or hand-write solution XML (e.g. `customizations.xml`, `solution.xml`) under `solutions/src/`. Only content produced by `pac solution unpack` from a real environment belongs there.

## External References

When Power Automate / Power Platform behavior or supported functionality must be verified, prefer Microsoft official documentation.
