from flask import Flask, Response
from pyswip import Prolog

app = Flask(__name__)

@app.route('/')
def hello_world():
    prolog = Prolog()

    # Load your Prolog file
    prolog.consult("test.pl")

    query = list(prolog.query("say_hello(X)"))

    # Get the result and return it as plain text
    if query:
        return Response(query[0]["X"], content_type='text/plain')
    else:
        return Response("No result found", content_type='text/plain')


if __name__ == '__main__':
    app.run(debug=True, port=8080)
