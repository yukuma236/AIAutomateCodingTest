# Research Task

Establish and document the business requirements and current state before planning or implementation. Research is collaborative: use the supplied description and relevant project documents as the starting point, then ask focused questions when a missing decision could change business behavior. Do not treat an inference, an example, or silence as approval.

## Inputs and source handling

1. Start with the user's business description and any supplied paths to requirements, process specifications, data models, or existing flow documents. Inspect only relevant project documents; preserve and reuse existing material instead of asking the user to recreate it.
2. Treat a data model as evidence for field names, types, and relationships only. It may help identify questions, but it does not establish business purpose, processing rules, timing, recipients, or exception behavior.
3. Separate confirmed facts (with their source), proposals, assumptions, and unresolved questions. Ask about unresolved points that affect business behavior before calling a specification approved.
4. Follow project-specific requirements first. Read the applicable shared standards through `standards/docs/README.md`; load only relevant documents. If the submodule includes `.github/copilot-instructions.md`, open it explicitly because submodule instructions are not automatically applied to this repository. Apply the Apps common standard together with the Power Automate differences; do not duplicate or silently override them.

## Requirements and design artifacts

When requirements are being formed from a business description, use the existing artifacts and the standards' order rather than jumping directly to a flow design:

1. Draft or update the BFC from the business requirements. Capture business activities/use cases and candidate functions; do not derive business requirements from a data model alone.
2. Record use-case dependencies, then prepare the feature list. Propose feature-ID candidates only with their supporting basis and unresolved points; do not assign or present a candidate as a formally approved ID.
3. After the feature list and IDs are confirmed, update the BFC with the formal IDs, then create or update the data-flow mapping.
4. Prepare the individual flow's processing specification from the approved business behavior. It describes what the flow does, including business-visible inputs, outputs, notifications, responses, and failure behavior. Keep technical construction details and test cases out of it; do not copy the same detail into multiple artifacts.
5. Prepare Test Specification and Test Case from the approved requirements and processing specification, following the applicable schema and test standards. Derive decision tables, MC/DC and boundary-value cases where applicable. Never invent expected results from observed implementation behavior.

Keep the artifact responsibilities distinct: the BFC describes business activities, use cases, and functions across the business area; a processing specification describes the business behavior of one flow; a data model is the basis for data fields, types, and relationships. Do not replace or regenerate existing documents wholesale when a focused update will do.

For notification or response requirements, capture the trigger, target-selection conditions, recipients, message/content sources, timing, duplicate handling, and business behavior on delivery failure or retry. Treat the notification as an external business output, distinct from data/processing rules and from visual screen design. Do not assume that a shared notification flow is required; record commonization only when it is an explicit, approved requirement.

## Existing flow and sample research

If the task concerns the current implementation of an existing Power Automate cloud flow:

* Use the FlowAgent MCP server (`get_flow`, `list_flows`) to retrieve the current flow definition from the target environment before inspecting the implementation.
* Updating `src/flows/` through synchronization is allowed during Research and is not considered an implementation change.
* If synchronization cannot be completed, explicitly report that the current implementation could not be verified. Do not rely on potentially stale files under `src/flows/` as the current state.
* Inspect the synchronized definition together with project requirements and applicable standards.
* If the task concerns a failed or unexpected run, use `get_run_history`, `get_run_actions`, `get_run_action_content`, `get_run_action_repetitions`, and `diagnose_run` as needed.

If the task is for a brand-new cloud flow, check section 8 (implementation-pattern index) of `standards/docs/power_automate_dev_standard.md` and relevant samples under `standards/samples/flows/`. Record matching samples and the patterns worth reusing, or explicitly state that no close sample was found.
Reuse relevant sample patterns where applicable, such as error-handling scopes, trigger shape, Switch/Upsert structure, or external API calls.

## Research output and approval gate

Provide a concise, durable Research handoff that identifies:

* requested business outcome and scope
* relevant existing documents and current-state evidence
* confirmed facts, proposed interpretations, and unresolved business decisions
* affected use cases, candidate/formal feature IDs, data flows, flows, connections, and environments as applicable
* relevant standards, sample patterns, constraints, risks, conflicts, and validation implications
* artifacts drafted or updated and where they are stored

Do not make flow implementation changes in Research. Clearly mark business specifications as **draft** until the responsible user explicitly approves them. Do not move to Plan while a decision affecting business behavior is unresolved or the required specification approval is missing.
