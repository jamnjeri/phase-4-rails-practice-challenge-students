class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /instructors
    def index
        instructors = Instructor.all
        render json: instructors
    end

    # GET /instructors/:id
    def show
        instructor = find_instructor
        render json: instructor
    end

    # Post /instructors
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    # PATCH /instructors/:id
    def update
        # find
        instructor = find_instructor
        # update
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    # DELETE /instructors/:id
    def destroy
        # find
        instructor = find_instructor
        # delete
        instructor.destroy
        head :no_content
    end

    private

    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
    end

end
