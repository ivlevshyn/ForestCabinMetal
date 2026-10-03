# Whole-lesson response template

Read TEACHING before using this template. Deliver one coherent lesson message where practical. Internal headings organize the explanation; they are not requests for a reply between sections. Use the actual repository at the stated commit.

## 1. Outcome and starting point

Explain the visible result, why the cabin needs it, and which current files and concepts it extends. Use PROGRESS rather than repeating onboarding. If access or a critical prerequisite is missing, resolve that specifically before pretending to give an exact walkthrough.

## 2. Theory explained from the foundations

Expand every required lesson concept into plain-language meaning, purpose, mechanism, and its connection to the project. Define terms and unfamiliar syntax. Use worked examples, small calculations, or diagrams when helpful. Explain the expected result yourself here; questions for the learner come at the end. Do not merely paste the short concept list from the lesson file.

## 3. Explained implementation walkthrough

Introduce the implementation structure, then show coherent snippets in dependency order. For each snippet use a placement block like this:

- **File:** exact repository-relative path; state explicitly if it is new.
- **Location:** existing type/function or new shader entry point.
- **Action:** add / replace / remove, with a stable anchor.
- **Dependencies:** imports, properties, helper definitions, target membership, earlier snippets.

Explain why the change is needed, show clear code, then explain the important lines and their effect. Complete functions or short shaders are allowed when clearer than fragments. Keep demonstrated code coherent with the current project and identify any omitted surrounding code explicitly.

For this repository, a placement instruction may refer to `ForestCabinMetal/Renderer.swift`, `Renderer.prepare(device:view:)`, or `Renderer.draw(in:)` only after checking that the current commit still contains them. Future files must be introduced as new, not described as though they already exist.

Do not stop for an answer after each snippet. Expected results and debug symptoms may be explained inline, but offer any experiments only as optional suggestions in the final section.

## 4. Expected result, common mistakes, and recap

Explain what the completed implementation should do, how the new data flows through the frame, and the few failure modes most likely to confuse a beginner. End the teaching portion with a concise conceptual recap.

## 5. Practice, questions, and submission

Only here give the learner:

1. A checklist for applying the lesson and running it.
2. Optional exploration suggestions only if useful; experiments and extra variations are never required and need no report.
3. Understanding questions grouped together.
4. Acceptance criteria and the runtime evidence worth recording.
5. Commit/push directions and an exact-SHA review prompt.

If a genuine limit forces multiple teaching messages, state why and place this consolidated final section after the last teaching part. Do not demand intermediate quizzes or commits. Follow-up debugging can be interactive when the learner asks for help.
