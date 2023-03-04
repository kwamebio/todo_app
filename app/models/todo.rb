class Todo < ApplicationRecord
    belongs_to :user

    enum status: {
      pending: 0,
      done: 1,
      cancelled: 2
    }
end
