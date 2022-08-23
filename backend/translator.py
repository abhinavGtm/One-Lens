from deep_translator import GoogleTranslator
import joblib
import flask
from flask import request

app = flask.Flask(__name__)
app.config["DEBUG"] = True

# main index page route
@app.route('/')
def home():
    return '<h1>API is working.. </h1>'

@app.route('/predict',methods=['GET'])
def predict():
    # to_translate = 'A paragraph is a collection of words strung together to make a longer unit than a sentence. Several sentences often make to a paragraph. There are normally three to eight sentences in a paragraph. Paragraphs can start with a five-space indentation or by skipping a line and then starting over. This makes it simpler to tell when one paragraph ends and the next starts'
    to_translate = request.args['s']
    tar = request.args['tar']
    translated = GoogleTranslator(source='auto', target=tar).translate(to_translate)
    print(translated)
    return flask.jsonify(str(translated))

if __name__ == "__main__":
    app.run(debug=True,port =8080)