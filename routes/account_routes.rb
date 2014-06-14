class Ollert
  post '/authenticate' do
    user = User.find email: params['email']
    if user.nil?
      flash[:warning] = "Email address #{params['email_address']} does not appear to be registered."
      redirect :login
    elsif !user.authenticate? params['password']
      flash[:warning] = "I didn't find that username/password combination. Check your spelling."
      redirect :login
    else
      flash[:success] = "Welcome back."
      session[:user] = user.id
      redirect '/'
    end
  end

  get '/signup' do
    haml_view_model :signup, @user
  end

  post '/signup' do
    msg = validate_signup(params)
    if msg.empty?
      user = User.new
      user.email = params[:email]
      user.password = params[:password]

      if user.save
        session[:user] = user.id
        flash[:success] = "You're signed up! Click below to connect with Trello for the first time."
        redirect '/'
      else
        flash[:error] = "Something's broken, please try again later."
        @email = params[:email]
        haml_view_model :signup
      end
    else
      flash[:error] = msg
      @email = params[:email]
      haml_view_model :signup
    end
  end

  get '/login' do
    haml_view_model :login
  end

  post '/logout', :auth => :authenticated do
    session[:user] = nil
    session[:token] = nil
    flash[:success] = "Come see us again soon!"

    redirect '/'
  end

  get '/settings/trello/disconnect', :auth => :authenticated do
    @user.member_token = nil
    @user.trello_name = nil

    if !@user.save
      flash[:error] = "I couldn't quite disconnect you from Trello. Do you mind trying again?"
    else
      flash[:success] = "Disconnected from Trello."
    end

    redirect '/settings'
  end

  post '/settings/email', :auth => :authenticated do
    msg = validate_email params[:email]
    if msg.empty?
      @user.email = params[:email]

      if @user.save
        flash[:success] = "Your new email is #{@user.email}. Use this to log in!"
      else
        flash[:error] = "I couldn't quite update your email. Do you mind trying again?"
      end
    else
      flash[:error] = msg
    end

    redirect '/settings'
  end

  post '/settings/password', :auth => :authenticated do
    current_pw = params[:current_password]
    new_password = params[:new_password]
    confirm_password = params[:confirm_password]

    if current_pw.nil_or_empty?
      flash[:error] = "Enter your old password so I know it's really you."
      redirect '/settings'
    end

    if !@user.authenticate? current_pw
      flash[:error] = "The current password entered is incorrect. Try again."
      redirect '/settings'
    end

    if new_password.nil_or_empty?
      flash[:error] = "New password must be at least 1 character in length."
      redirect '/settings'
    end

    if new_password != confirm_password
      flash[:error] = "Could not confirm new password. Type more carefully."
      redirect '/settings'
    end

    @user.password = new_password
    if !@user.save
      flash[:error] = "Password could not be changed. Do you mind trying again?"
      redirect '/settings'
    end

    flash[:success] = "Password has been changed."
    redirect '/settings'
  end

  get '/settings/trello/connect', :auth => :authenticated do
    session[:token] = params[:token]

    client = get_client ENV['PUBLIC_KEY'], session[:token]

    token = client.find(:token, session[:token])
    member = token.member

    @user.member_token = session[:token]
    @user.trello_name = member.attributes[:username]

    if !@user.save
      flash[:error] = "I couldn't quite connect you to Trello. Do you mind trying again?"
    else
      flash[:success] = "Connected you to the Trello user #{@user.trello_name}"
    end

    redirect '/settings'
  end

  post '/settings/delete', :auth => :authenticated do
    if params[:iamsure] == "on"
      email = @user.email

      session[:user] = nil
      session[:token] = nil
      if @user.delete
        flash[:success] = "User with login of #{email} has been deleted. Come back and sign up again one day!"
        redirect '/'
      else
        flash[:error] = "I wasn't able to delete that user. Do you mind trying again?"
        redirect '/settings'
      end
    else
      flash[:warning] = "You must check the 'I am sure' checkbox to delete your account."
      redirect '/settings'
    end
  end

  get '/settings', :auth => :authenticated do
    haml_view_model :settings, @user
  end
end