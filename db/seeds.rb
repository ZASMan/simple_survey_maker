polyglot_confessions_survey = Survey.create!(
  title: "Polyglot Confessions Survey",
  description: "An anonymous survey for polyglot community members."
)

question_1 = Question.create!(
  title: "Confess anything!",
  description: "Pour your heart out to the polyglot community.
  Please do not submit abusive or bullying content.",
  survey: polyglot_confessions_survey
)

filter = ContentFilter.create!