class UserMailer < ApplicationMailer

  default from: 'cooking-challenges.herokuapp.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://cooking-challenges.herokuapp.com' 
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def invitation_email(user, raw)
    @user = user
    @raw = raw
    @url  = edit_user_password_url(reset_password_token: @raw)
    mail(to: @user.email, subject: 'tu es invités au Cooking Challenge !') 
  end

end
