SMTP_SETTINGS = {
  address: 'simplesurveymaker.herokuapp.com', # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: 'heroku.com', # example: "heroku.com"
  enable_starttls_auto: true,
  password: ENV.fetch("SMTP_PASSWORD"),
  port: "587",
  user_name: ENV.fetch("SMTP_USERNAME")
}
