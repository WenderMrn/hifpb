require 'test_helper'

class Admin::ImportControllerTest < ActionDispatch::IntegrationTest

  test 'should import campus from suap' do
    get admin_importar_campus_url
    assert_response :success

    assert_not_empty Campus.all
  end

  test 'should not duplicate campus in import stage' do
    get admin_importar_campus_url

    count = Campus.count
    get admin_importar_campus_url

    assert_equal count, Campus.count
  end

  test 'should import courses from suap' do
    get admin_importar_campus_url
    get admin_importar_courses_url(id_campus: 39, ano_letivo: 2017, periodo_letivo: 1)

    assert_response :success
    assert_not_nil Course.find_by(campus: 39)
  end

  test 'should not duplicate courses in import stage' do
    get admin_importar_campus_url
    get admin_importar_courses_url(id_campus: 39, ano_letivo: 2017, periodo_letivo: 1)

    count = Course.count
    get admin_importar_courses_url(id_campus: 39, ano_letivo: 2017, periodo_letivo: 1)

    assert_equal count, Course.count
  end


end
