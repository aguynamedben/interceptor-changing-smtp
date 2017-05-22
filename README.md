# Config Notes

Things to note:

* .env.development is setting up some ENV variable for the SMTP server. The config assumes you're using the mailcatcher gem locally to catch sent emails.
* config/initializers/smtp.rb is setting up Rails.application.config.action_mailer.smtp_settings to use those ENV variables
* We have an interceptor setup in app/mailers/sent_email_interceptor.rb, as defined in the [ActionMailer docs](http://guides.rubyonrails.org/action_mailer_basics.html#intercepting-emails).
* bin/rake email:try_send can be used to send the new user email

## Problem

When I try to send email with SMTP settings configured through dotenv ENV variables + initializer...

```
bin/rake email:try_send --trace
```

the send fails with the following error message:

```
Bens-Work-Laptop!ben:/Users/ben/code/interceptor-changing-smtp$ bin/rake email:try_send --trace
Running via Spring preloader in process 26280
** Invoke email:try_send (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute email:try_send
rake aborted!
Errno::ECONNREFUSED: Connection refused - connect(2) for "localhost" port 25
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:542:in `initialize'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:542:in `open'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:542:in `tcp_socket'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:552:in `block in do_start'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/timeout.rb:91:in `block in timeout'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/timeout.rb:101:in `timeout'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:551:in `do_start'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/net/smtp.rb:521:in `start'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/mail-2.6.5/lib/mail/network/delivery_methods/smtp.rb:113:in `deliver!'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/mail-2.6.5/lib/mail/message.rb:2149:in `do_delivery'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/mail-2.6.5/lib/mail/message.rb:237:in `block in deliver'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionmailer-5.1.1/lib/action_mailer/base.rb:558:in `block in deliver_mail'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/notifications.rb:166:in `block in instrument'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/notifications/instrumenter.rb:21:in `instrument'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/notifications.rb:166:in `instrument'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionmailer-5.1.1/lib/action_mailer/base.rb:556:in `deliver_mail'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/mail-2.6.5/lib/mail/message.rb:237:in `deliver'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionmailer-5.1.1/lib/action_mailer/message_delivery.rb:96:in `block in deliver_now'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionmailer-5.1.1/lib/action_mailer/rescuable.rb:15:in `handle_exceptions'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionmailer-5.1.1/lib/action_mailer/message_delivery.rb:95:in `deliver_now'
/Users/ben/code/interceptor-changing-smtp/lib/tasks/email.rake:3:in `block (2 levels) in <top (required)>'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:250:in `block in execute'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:250:in `each'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:250:in `execute'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:194:in `block in invoke_with_call_chain'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/2.3.0/monitor.rb:214:in `mon_synchronize'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:187:in `invoke_with_call_chain'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/task.rb:180:in `invoke'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:152:in `invoke_task'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:108:in `block (2 levels) in top_level'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:108:in `each'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:108:in `block in top_level'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:117:in `run_with_threads'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:102:in `top_level'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:80:in `block in run'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:178:in `standard_exception_handling'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/rake-12.0.0/lib/rake/application.rb:77:in `run'
/Users/ben/code/interceptor-changing-smtp/bin/rake:9:in `<top (required)>'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/dependencies.rb:286:in `load'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/dependencies.rb:286:in `block in load'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/dependencies.rb:258:in `load_dependency'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/activesupport-5.1.1/lib/active_support/dependencies.rb:286:in `load'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/site_ruby/2.3.0/rubygems/core_ext/kernel_require.rb:55:in `require'
/Users/ben/.rbenv/versions/2.3.1/lib/ruby/site_ruby/2.3.0/rubygems/core_ext/kernel_require.rb:55:in `require'
-e:1:in `<main>'
Tasks: TOP => email:try_send
```

Oddly, the log line in SentEmailInterceptor shows the correctly-configured value:

```
We're using the SMTP settings: {:address=>"127.0.0.1", :domain=>"127.0.0.1", :port=>"1025", :user_name=>"", :password=>"", :authentication=>:plain, :tls=>false}
```

but obviously, given the error message, the SMTP settings are reverting when the email is actually sent.

## Telling Workaround

If I uncomment the following lines in config/environments/development.rb, configuing ActionMailer directly, and not through dotenv + initializer, the email works fine and I receive it in mailcatcher:

```
  # config.action_mailer.smtp_settings = {
  #   address: "127.0.0.1",
  #   domain: "127.0.0.1",
  #   port: "1025",
  #   user_name: "",
  #   password: "",
  #   authentication: :plain,
  #   tls: false
  # }
```

(uncomment these lines in development.rb, run `bin/rake email:try_send --trace`, and you'll see the email is sent as expected)

### Summary

There appears to be some conflict between dotenv, initializers, ActionMailer, and possibly ActionMailer interceptors.
