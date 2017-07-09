require 'test_helper'

class Admin::LessonsControllerTest < ActionDispatch::IntegrationTest
  test "must not be saved when times are already" do
    # skip
    lesson = Lesson.new(
      {"day"=>"Segunda", "laboratory"=>laboratories(:one), "schoolroom"=>schoolrooms(:one),"classroom"=> classrooms(:one),"campus_schedule"=> campus_schedules(:one)}
    )
    assert_not lesson.save
  end

  test "can not save if the teacher already teaches at this time" do
    # skip
    lesson = Lesson.new(
      {"day"=>"Segunda", "laboratory"=>laboratories(:one), "schoolroom"=>schoolrooms(:one),"classroom"=> classrooms(:two),"campus_schedule"=> campus_schedules(:one)}
    )
    assert_not lesson.save
  end

end
