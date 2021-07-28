for i in {1..100}
do
curl -F "audio=@samples/2830-3980-0043.wav" -X POST 10.118.0.28:5000/model/predict
done
