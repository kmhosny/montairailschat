### Monta AI Rails Chat

The Monta AI task is developed using Ruby on Rails instead of the most go to options.

### Why Rails

Python is great, I know it's great but for computation and writing a more granular mathematical/data manipulation code.
Most frameworks I've seen for SaaS apps, specially following MVC, in python aren't very optimised for such apps and don't provide a standard way to write such code. Ruby on Rails on the other hand is mature in this domain and can provide a much smoother development for such apps.

### does a GPT app follow the same SaaS pattern?
Great question and from what I see the answer is yes. the GPT engine is just another processing block for data so no need to treat GPT based apps any different.

### Application architecture
The app serves 2 clients, web and through API.

When using the app through web client, it uses cookies to create user sessions while through APIs it uses JWT to authenticate and authorize the user for actions.

#### Available APIs
API documentations can be accessed through swagger at https://montairailschat.onrender.com/api-docs

#### Database design
The app holds 2 simple tables:
1. users which consists of email and password.
2. chat_histories which holds all the messages and chat between the user and GPT-3.5. It's attributes are: message, message_type (either request or response), user_id, created_at, updated_at


# How to run the app
1. run `bundle install` to install all necessary gems
2. run db migrations through `rails db:prepare`
3. run the application by calling `bin/dev`
4. go to http://localhost:3000

Ruby version is already added as part of the repo so make sure to have ruby installed.
