class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def differences
    require 'net/http'

    # url = URI.parse("http://apimasalarms.herokuapp.com/assignments.json")
    # http = Net::HTTP.new(url.host, url.port)
    # request = Net::HTTP::Get.new(url.request_uri)
    # http.use_ssl = true  
    # res = http.request(request)

    url = URI.parse('http://apimasalarms.herokuapp.com/assignments.json')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    api_assignments = JSON.parse(res.body)
    db_assignments = JSON.parse(Assignment.all.to_json)

    result = []
    api_names = []
    db_names = []
    
    api_assignments.map {|aa| api_names << aa["description"]}
    db_assignments.map {|da| db_names << da["description"]}

    api_names.each_with_index do |name, index|
      unless db_names.include?(name)
        result << {id: api_assignments[index]["id"]}
      end
    end
    render json: result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:limit_date, :description, :grade)
    end
end
