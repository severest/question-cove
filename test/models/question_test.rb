require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "should have first line" do
    q = Question.create(text: '# This is my title')
    assert_equal q.first_line, '<h1>This is my title</h1>
'
    assert_equal q.first_line_for_slug, ' This is my title'
  end

  test "should return sorted answers" do
    question = create(:question)
    answer1 = create(:answer, question: question)
    answer2 = create(:answer, question: question)
    answer3 = create(:answer, question: question)
    create(:vote, voteable: answer3, vote: 1)
    create(:vote, voteable: answer3, vote: 1)
    create(:vote, voteable: answer3, vote: -1)
    assert_equal question.sorted_answers[0].id, answer3.id
  end

  test "should return all participating users" do
    users = create_list(:user, 4)
    q = create(:question, user: users[0])
    create(:comment, user: users[3], post: q)
    a = create(:answer, user: users[1], question: q)
    create(:comment, user: users[2], post: a)
    create(:comment, user: users[2], post: a)
    assert_equal users.pluck('id'), q.all_users_involved.pluck(:id)
  end

  test "should sort by created_at" do
    q1 = create(:question)
    q2 = create(:question)
    q3 = create(:question)
    assert_equal Question.get_ordered_questions('created_at').pluck('id'), [q1.id, q2.id, q3.id]
  end

  test "should sort by views" do
    q1 = create(:question)
    create_list(:user_question_view, 1, question: q1)
    q2 = create(:question)
    create_list(:user_question_view, 3, question: q2)
    q3 = create(:question)
    assert_equal Question.get_ordered_questions('views').pluck('id'), [q2.id, q1.id, q3.id]
  end

  test "should sort by created_at by default" do
    q1 = create(:question)
    q2 = create(:question)
    q3 = create(:question)
    assert_equal Question.get_ordered_questions('created_at').pluck('id'), [q1.id, q2.id, q3.id]
    assert_equal Question.get_ordered_questions('jos').pluck('id'), [q1.id, q2.id, q3.id]
  end

  test "should sort by unanswer" do
    q1 = create(:question)
    a = create(:answer, question: q1)
    q1.best_answer = a
    q1.save
    q2 = create(:question)
    q3 = create(:question)
    assert_equal Question.get_ordered_questions('unanswered').pluck('id'), [q2.id, q3.id, q1.id]
  end
end
