class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /students
    def index
        students = Student.all
        render json: students
    end

    # GET /students/:id
    def show
        student = find_student
        render json: student
    end

    # POST /students
    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    # PATCH /students/:id
    def update
        # find
        student = find_student
        # update
        student.update!(student_params)
        render json: student, status: :accepted
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    # DELETE /students/:id
    def destroy
        # find
        student = find_student
        # delete
        student.destroy
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end
end
