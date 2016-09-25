ActionMailer::Base.smtp_settings = {  
    :address              => "smtp.gmail.com",  
    :port                 => 587,  
    :user_name            => "schedulesmasher16",  
    :password             => "schedulesmashingiscool",  
    :authentication       => "plain",  
    :enable_starttls_auto => true  
  }