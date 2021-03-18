class UserMailer < ApplicationMailer

  default from: 'cooking@yopmail.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://cooking-challenges.herokuapp.com' 
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def invitation_email_new_user(user, raw, current_user)
    @user = user
    @current_user = current_user
    @raw = raw
    @url  = edit_user_password_url(reset_password_token: @raw)
    #@url  = "https://cooking-challenges.herokuapp.com/users/password/edit#{(reset_password_token: @raw)}"
    mail(to: @user.email, subject: current_user.username.capitalize + " t'invite à son Cooking Challenge !") 
  end
  


  def invitation_email(user, current_user)
    @user = user
    @current_user = current_user
    #@url  = new_user_session_url
    @url  = "https://cooking-challenges.herokuapp.com/users/sign_in"
    mail(to: @user.email, subject: current_user.username.capitalize + " t'invite à son Cooking Challenge !") 
  end

end
