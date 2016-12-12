<?php
/**
 * Created by PhpStorm.
 * User: anis
 * Date: 04/12/2016
 * Time: 22:19
 */

namespace AppBundle\Command;


use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class RabbitMQListnerCommand extends Command
{
    public function configure()
    {
        $this->setName("app:rabbitmq-listner");
    }

    public function execute(InputInterface $input, OutputInterface $output)
    {
        $connection = new AMQPStreamConnection('192.168.40.2', 5672, 'common', 'common');
        $channel = $connection->channel();

        $channel->queue_declare('hello');

        echo ' [*] Waiting for messages. To exit press CTRL+C', "\n";

        $callback = function($msg) {
            echo " [x] Received ", $msg->body, "\n";
        };

        $channel->basic_consume('hello', '', false, true, false, false, $callback);

        while(count($channel->callbacks)) {
            $channel->wait();
        }

        $channel->close();
        $connection->close();
    }
}