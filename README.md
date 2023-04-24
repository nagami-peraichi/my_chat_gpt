# README

## Development environment
Run database.
```
cd dockerdev
docker compose up
```

Setup application.
```
setup
```

Run application.
```
dev
```

## Docker
Build image.
```
docker build -t my_chat_gpt .
```

Run a container.
```
docker run -e DATABASE_URL=postgres://postgres:postgres@host.docker.internal/my_chat_gpt_development -e SECRET_KEY_BASE=Dummy -p 5000:3000 -i -t my_chat_gpt
```

## API
Create a chat.
```
curl http://localhost:5000/chats -X POST -H "Content-Type: application/json" -d '{"chat":{"ai_model":"gpt-3.5-turbo"}}'
```

Create a completion.
```
curl http://localhost:5000/chats/2/completion -X POST -H "Content-Type: application/json" -d '{"message":{"content":"Hello"}}
```
