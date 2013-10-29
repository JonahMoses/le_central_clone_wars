<?php
	$emailTo = 'testmail@templatesquare.com';
	if($subject!=""){
	$subject =$_REQUEST['subject'];
	}else{
	$subject = 'LaMonte Contact Form';
	}
	$name=$_REQUEST['name'];
	$email=$_REQUEST['email'];
	$msg=$_REQUEST['msg'];

	$body = "Name: $name \n\nEmail: $email \n\nWebsite: $website \n\nMessage: $msg";
	$headers = 'From: '.$name.' <'.$email.'>' . "\r\n" . 'Reply-To: ' . $email;

	mail($emailTo, $subject, $body, $headers);
?>
