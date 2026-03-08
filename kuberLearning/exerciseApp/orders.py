from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/orders')
def get_orders():
    return jsonify({"service": "Order API", "data": [{"id": 101, "item": "Laptop"}]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
