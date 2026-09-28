# ---------- build stage: compile both NetBeans projects ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /src
COPY ch14_ex1_CreateAccount/src ./ch14_ex1_CreateAccount/src
COPY ch14_ex2_Hangman/src ./ch14_ex2_Hangman/src
RUN javac -encoding windows-1252 -d /out/createaccount ch14_ex1_CreateAccount/src/*.java \
 && javac -encoding windows-1252 -d /out/hangman ch14_ex2_Hangman/src/*.java

# ---------- runtime stage: console apps served in the browser via ttyd ----------
FROM eclipse-temurin:21-jre
RUN apt-get update \
 && apt-get install -y --no-install-recommends ttyd \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /out ./
# Hangman reads words.txt from the working directory
COPY ch14_ex2_Hangman/words.txt ./hangman/words.txt
COPY menu.sh ./menu.sh
RUN chmod +x ./menu.sh

ENV TERM=xterm-256color
# Render injects PORT (default 10000)
ENV PORT=10000
EXPOSE 10000

CMD ["sh", "-c", "exec ttyd --writable --port ${PORT} -t titleFixed='Murach Java - Chapter 14' -t fontSize=16 /app/menu.sh"]
