class Authorization < ActiveRecord::Base

  # надо ещё создать валидацию и тест на эту модель
  belongs_to :user
end
