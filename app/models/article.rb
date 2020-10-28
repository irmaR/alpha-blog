class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
    #reload! to latest change in the model
    #see errors to .save with article.errors.full_messages
    #create article: article = Article.new(title: "a", description: "b")

end