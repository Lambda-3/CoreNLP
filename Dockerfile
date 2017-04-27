FROM java:jre-alpine

EXPOSE 9000

RUN apk add --update --no-cache \
	wget

WORKDIR /corenlp
RUN wget http://nlp.stanford.edu/software/stanford-corenlp-models-current.jar && \
	wget http://nlp.stanford.edu/software/stanford-english-corenlp-models-current.jar && \
	wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-models-current.jar

ADD build/libs/CoreNLP-3.7.0.jar /corenlp/

CMD ["java", "-mx8g", "-server", "-cp", "*", \
     "edu.stanford.nlp.pipeline.StanfordCoreNLPServer", \
     "--port", "9000", \
     "--annotators", "tokenize,ssplit,pos,lemma,ner", \
     "--preload", "tokenize,ssplit,pos,lemma,ner", \
     "--timeout", "60000"]
