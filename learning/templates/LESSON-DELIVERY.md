# Step-based lesson delivery template

Read TEACHING before using this template. Teach a lesson over multiple messages, one coherent step per response by default. At the start, briefly map the steps, then deliver only the current step. Use the inspected repository and actual learner progress.

## 1. Current step and outcome

Name the lesson and step/task ID. Explain its result, why the cabin needs it, and its connection to prior work. Use PROGRESS rather than repeating onboarding. Resolve essential access or prerequisite issues before claiming an exact walkthrough.

## 2. Theory for this step

Explain the required concepts fully: meaning, purpose, mechanism, connection, and worked examples. Define unfamiliar syntax and mathematical variables. Demonstrate calculations and predictions yourself. Preserve thorough explanations across the sequence; do not front-load the entire lesson's theory or replace explanation with a quiz.

## 3. File responsibilities before adding code

Inspect the affected files and say where the new responsibility belongs. If a file is accumulating unrelated jobs, teach a focused extraction in this step or a preparatory step. Explain which symbols move, their new paths, and old definitions/callers to update. Preserve ownership, residency, synchronization, and CPU/MSL layouts. Avoid arbitrary line limits, speculative architecture, and unnecessary tiny files.

## 4. Explained implementation

Show coherent snippets in dependency order. For each snippet provide:

- **File:** exact repository-relative path; explicitly identify a new file.
- **Location:** existing type/function or new shader entry point.
- **Action:** add / replace / remove / move, with a stable anchor.
- **Dependencies:** imports, properties, helpers, target membership, access-control changes, and earlier snippets.

Explain the purpose before the code and the important lines afterward. Complete functions or short shaders are welcome when clearer than fragments. Identify omitted surrounding code explicitly. Ground placement in inspected source; do not assume every change belongs in Renderer.swift.

## 5. Expected behavior and step boundary

Describe the result, likely mistakes, and a short apply/run checklist for this step. Pause here so the learner can implement it, ask for help, or request the next step. Do not append the next step automatically. Do not require a specific acknowledgment word, a quiz, a commit, or a formal review at each boundary. Answer learner questions and debug as needed before resuming.

## 6. Final step only: practice, questions, and submission

After all teaching steps, provide:

1. A consolidated checklist for the complete lesson.
2. Optional exploration ideas if useful; no experiment report is required.
3. All understanding questions together, with duplicates removed.
4. Acceptance criteria and relevant runtime evidence to record.
5. Commit/push directions and an exact-SHA review prompt.

Do not put understanding questions at the ends of earlier steps. Necessary setup and debugging questions remain allowed. Record the current step and implementation status when making a session handoff; reading a step does not prove it was implemented.
