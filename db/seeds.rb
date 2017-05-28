User.create({:id => 1, :email => 'test@example.com', :name => 'Tester 1')
User.create({:id => 2, :email => 'another@example.com', :name => 'Tester 2')
User.create({:id => 3, :email => 'onemore@example.com', :name => 'Tester 3')

Question.create({:id => 1, :text => '# Markdown styling
This is an example of how to use markdown within the question body.

* a list item
* another

## subheading

**bold text**

[a link](https://questioncove.thealtitude.ca)', :user_id => 2, :views => 15, :total_votes => 0, :slug => 'markdown-styling'})

Question.create({:id => 2, :text => '# First question
This is an example of a question one might ask.
Other users would then upvote the question itself if they too are looking for answers or
answer the question if they are familiar with the problem. Users may also vote on answers that work for them.', :user_id => 1, :views => 5, :total_votes => 0, :slug => 'first-question'})


ActsAsTaggableOn::Tag.create({:id => 1, :name => 'test', :taggings_count => 0})
ActsAsTaggableOn::Tag.create({:id => 2, :name => 'markdown', :taggings_count => 0})
ActsAsTaggableOn::Tagging.create({:tag_id => 1, :taggable_id => 2, :taggable_type => 'Question', :context => 'tags'})
ActsAsTaggableOn::Tagging.create({:tag_id => 2, :taggable_id => 1, :taggable_type => 'Question', :context => 'tags'})
