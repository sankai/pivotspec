require 'Pivotablecube'
class CarspecsController < ApplicationController
  # GET /carspecs
  # GET /carspecs.json
  def index
    @carspecs = Carspec.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carspecs }
    end
  end

  # GET /carspecs/1
  # GET /carspecs/1.json
  def show
    @carspec = Carspec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carspec }
    end
  end

  # GET /carspecs/new
  # GET /carspecs/new.json
  def new
    @carspec = Carspec.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carspec }
    end
  end

  # GET /carspecs/1/edit
  def edit
    @carspec = Carspec.find(params[:id])
  end

  # POST /carspecs
  # POST /carspecs.json
  def create
    @carspec = Carspec.new(params[:carspec])

    respond_to do |format|
      if @carspec.save
        format.html { redirect_to @carspec, notice: 'Carspec was successfully created.' }
        format.json { render json: @carspec, status: :created, location: @carspec }
      else
        format.html { render action: "new" }
        format.json { render json: @carspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carspecs/1
  # PUT /carspecs/1.json
  def update
    @carspec = Carspec.find(params[:id])

    respond_to do |format|
      if @carspec.update_attributes(params[:carspec])
        format.html { redirect_to @carspec, notice: 'Carspec was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carspecs/1
  # DELETE /carspecs/1.json
  def destroy
    @carspec = Carspec.find(params[:id])
    @carspec.destroy

    respond_to do |format|
      format.html { redirect_to carspecs_url }
      format.json { head :no_content }
    end
  end
  
  # ------------------------------------------------------------------
  # DB‚©‚çŽ²î•ñ‚ðŽæ“¾‚µATree\‘¢‚ðì‚é
  # ------------------------------------------------------------------
  def createAxises
    aHash = Hash.new()
    Carspec.group('spectype').order('spectype').each do | type |
      anArray = Array.new
      Carspec.where(:spectype => type.spectype).each do | carspec |
        anArray.push(carspec.specname)      
      end
      aHash.store(type.spectype, anArray)      
    end

    pivotableCube = Pivotablecube.new()
    aHash.each do | key, value |
      pivotableCube.addAxis(key, value)
    end
    pivotableCube.defineNodeClass(Caroption)
    pivotableCube.createcube() 
    
    @cube = pivotableCube
    
    render :showtree
  end
end
