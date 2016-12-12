#!/usr/bin/env node

var amqp = require('amqplib/callback_api');

amqp.connect({hostname : "192.168.40.2", username : "common", password: "common"}, {}, function(err, conn) {
	if (err) {
		console.error(err);
		return;
	}
	
	conn.createChannel(function(err, ch) {
		var q = 'hello_node';

		ch.assertQueue(q, {durable: false});
		
		//publisher
		// Note: on Node 6 Buffer.from(msg) should be used
		/*ch.sendToQueue(q, new Buffer('Hello World!'));
		console.log(" [x] Sent 'Hello World!'");
		*/
		
		
  
		// consumer
		ch.assertQueue(q, {durable: false});
		console.log(" [*] Waiting for messages in %s. To exit press CTRL+C", q);
		ch.consume(q, function(msg) {
		  console.log(" [x] Received %s", msg.content.toString());
		}, {noAck: true});
	});
});