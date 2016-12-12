<?php
/**
 * Created by PhpStorm.
 * User: anis
 * Date: 04/12/2016
 * Time: 22:28
 */

namespace AppBundle\Command;


use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class RabbitMQPublisherCommand extends Command
{
    public function configure()
    {
        $this->setName("app:rabbitmq-publisher");
    }

    public function execute(InputInterface $input, OutputInterface $output)
    {
        $connection = new AMQPStreamConnection('192.168.40.2', 5672, 'common', 'common');
        $channel = $connection->channel();

        $channel->queue_declare('hello');

        $msg = new AMQPMessage('Hello World!');
        $channel->basic_publish($msg, '', 'hello');

        echo " [x] Sent 'Hello World!'\n";

        $channel->close();
        $connection->close();
    }

}