# Setting up Jakarta Mail for Email Verification

## Step 1: Add Required Dependencies
1. Download the following JAR files:
   - jakarta.mail-2.0.1.jar
   - jakarta.mail-api-2.0.1.jar
   - jakarta.activation-2.0.1.jar
2. Place these JAR files in your project's `lib` directory

## Step 2: Update Import Statements
Replace the following imports in SignupServlet.java:
```java
import javax.mail.*;
import javax.mail.internet.*;
```
with:
```java
import jakarta.mail.*;
import jakarta.mail.internet.*;
```

## Step 3: Configure Gmail SMTP Settings
1. Enable 2-Step Verification in your Gmail account:
   - Go to Google Account settings
   - Security > 2-Step Verification > Turn it on

2. Generate an App Password:
   - Go to Google Account settings
   - Security > 2-Step Verification > App passwords
   - Select 'Mail' and your device
   - Copy the generated 16-character password

3. Update SMTP Configuration in SignupServlet.java:
```java
final String senderEmail = "your.email@gmail.com";
final String senderPassword = "your-16-digit-app-password";

Properties props = new Properties();
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
```

## Step 4: Error Handling
Add proper error handling for email sending:
```java
try {
    Transport.send(message);
    // Success handling
} catch (MessagingException e) {
    // Log the error
    e.printStackTrace();
    // Show user-friendly error message
    response.sendRedirect("error.jsp");
}
```

## Common Issues and Solutions
1. ClassNotFoundException: Make sure all JAR files are properly added to the build path
2. AuthenticationFailedException: Verify your App Password is correct
3. Connection timeout: Check your internet connection and firewall settings

## Testing
1. Try sending a test email after configuration
2. Check spam folder if emails are not received
3. Monitor server logs for any errors