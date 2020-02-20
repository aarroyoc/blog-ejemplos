Feature: comments

@wip
Scenario: add a comment in blog post
Given a post page is loaded
    """
    Lorem Ipsum
    """
When I add a comment 
    | text | username |
    | Hey! | aarroyoc |
    | Bye! | marlogui |
Then the page is reloaded
And the page shows a confirmation message
And the comment is registered in the database with text "your post looks interesing"

@data-1
Scenario: approve comment
Given the comment is registered in the database with text "your post looks interesing"
And I can't see the comment in the post page
When I approve the comment
Then I can see the comment in the post page
