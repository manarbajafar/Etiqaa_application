from camel_tools.utils.normalize import normalize_alef_maksura_ar, normalize_teh_marbuta_ar, normalize_alef_ar
from camel_tools.tokenizers.word import simple_word_tokenize
from camel_tools.disambig.mle import MLEDisambiguator
from camel_tools.utils.dediac import dediac_ar

import pickle
import re

import os # used for operating system functionalitie s -method getcwd() returns current working directory of a process-

#for API
from flask import Flask,jsonify,request
from flask_cors import CORS
import json


app = Flask(__name__) #intance of our flask application 


CORS(app)
cors = CORS(app, resource={
    r"/*":{
        "origins":"*"
    }
})

def cleaning(text):

  # these stuff starting with a (\u) represent the ASCII of Arabic characters and digits in addition to tashkil and punctuation, take a look to this website >> https://unicode-table.com/en/blocks/arabic/, https://ar.wikipedia.org/wiki/%D8%A7%D9%84%D8%AE%D8%B7_%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A_%D9%81%D9%8A_%D9%8A%D9%88%D9%86%D9%8A%D9%83%D9%88%D8%AF
  cleaned_text = re.sub(r'[^\u0621-\u06D3|\u0660-\u066D|^\uFB50-\uFBE9|^\uFE80-\uFEFC]',' ', text) # remove any non-Arabic char

  cleaned_text = re.sub(r'[\u064B-\u065F]|\u0640|\u0670]','', cleaned_text) # remove some Arabic symbols and diactrties

  cleaned_text = re.sub(r'([\u0621-\u06D3|\uFB50-\uFBE9|\uFE80-\uFEFC])\1{2,}', r'\1', cleaned_text) # replace reapeted of more than 2 char to be only 1 

  cleaned_text = re.sub(r'\s\s+',' ', cleaned_text) # replace extra spaces with one space

  cleaned_text = cleaned_text.strip() # trim spaces

  return cleaned_text




mle = MLEDisambiguator.pretrained() #هذا يستخدم في ميثود المعالجة، بس حبذا يترك لحاله لان استدعاؤه ثقيل


def ANLP(text):

  normalized_text = normalize_teh_marbuta_ar(normalize_alef_ar(normalize_alef_maksura_ar(text))) # normalize the sentence
  tokens = simple_word_tokenize(normalize_alef_ar(normalized_text)) # tokenize the sentence into list of words
  
  disambig = mle.disambiguate(tokens) # analyse each token
  lem = [d.analyses[0].analysis['lex'] for d in disambig] # take the lemma

  dediac_text = dediac_ar(' '.join(lem))
     
  processedText = normalize_teh_marbuta_ar(normalize_alef_ar(normalize_alef_maksura_ar(dediac_text)))

  return processedText

#==========================================================================================================================================================================



def relativePath(path):
    cwd = os.getcwd()
    return cwd+"/python_files/"+path

result = ''


#Route '/' to facilitate get request from our flutter app
@app.route('/', methods = ['POST'])

def index():

  # import trained vectorizer and model
  vectorizer = pickle.load(open(relativePath("LemCountVectorizer.pickle"), "rb")) # rb stand for read binary
  model = pickle.load(open(relativePath("LR_LemModelWithSW_81,2.pickle"), "rb"))



  request_data = request.data #getting the response data
  request_data = json.loads(request_data.decode('utf-8')) #converting it from json to key value pair
  text = request_data['message'] #assigning it to name
 

  cleanedText = cleaning(text)
  print(cleanedText)
   

  processedText = [ANLP(cleanedText)]
  print(processedText)

  featuredText = vectorizer.transform(processedText)
  predictedClass = model.predict(featuredText)
  print(predictedClass)
  print(type(predictedClass))

  result = str(predictedClass[0])

  return jsonify({'message' : result}) #returning key-value pair in json format



url='000.000.0.000'
portNum= 5000

if __name__ == "__main__":
    app.run(host = url, port = portNum, debug = True) #debug will allow changes without shutting down the server 



#  d={}
#     d['query']= str(request.args['query'])
#     return jsonify(d)