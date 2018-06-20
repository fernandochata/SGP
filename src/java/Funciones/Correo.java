package Funciones;

import DAO.*;
import DTO.*;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Fernando Chata
 */
public class Correo {
    
    public static void permisoParental(int rutFuncionario) throws AddressException, MessagingException {
        Properties mailServerProperties;
        Session getMailSession;
        MimeMessage generateMailMessage;
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        UsuarioDTO funcionario = usuarioDAO.read(rutFuncionario);
        
        UsuarioDTO jefeInterno = usuarioDAO.read_Perfil_Departamento(3, funcionario.getDepartamento());

        String emailTO = jefeInterno.getEmail();
        String emailSubject = "Permiso Parental";
        String emailBody = "<p>Se ingresó nuevo permiso parental de " + funcionario.getNombres() + " " + funcionario.getApellido_paterno() + ".</p>";
        
        String emailGmail = "sistemagestionpermisos@gmail.com";
        String claveGmail = "sgpadmin";
        
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(emailTO));
        generateMailMessage.setSubject(emailSubject);
        generateMailMessage.setContent(emailBody, "text/html");
        
        Transport transport = getMailSession.getTransport("smtp");

        transport.connect("smtp.gmail.com", emailGmail, claveGmail);
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    }
    
    public static void permisoFallecimiento(int rutFuncionario) throws AddressException, MessagingException {
        Properties mailServerProperties;
        Session getMailSession;
        MimeMessage generateMailMessage;
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        UsuarioDTO funcionario = usuarioDAO.read(rutFuncionario);
        
        UsuarioDTO jefeInterno = usuarioDAO.read_Perfil_Departamento(3, funcionario.getDepartamento());

        String emailTO = jefeInterno.getEmail();
        String emailSubject = "Permiso Parental";
        String emailBody = "<p>Se ingresó nuevo permiso por fallecimiento de " + funcionario.getNombres() + " " + funcionario.getApellido_paterno() + ".</p>";
        
        String emailGmail = "sistemagestionpermisos@gmail.com";
        String claveGmail = "sgpadmin";
        
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(emailTO));
        generateMailMessage.setSubject(emailSubject);
        generateMailMessage.setContent(emailBody, "text/html");
        
        Transport transport = getMailSession.getTransport("smtp");

        transport.connect("smtp.gmail.com", emailGmail, claveGmail);
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    }
    
    public static void sinAdjunto(String emailTO, String emailSubject, String emailBody) throws AddressException, MessagingException{
        
        Properties mailServerProperties;
        Session getMailSession;
        MimeMessage generateMailMessage;
        
        String emailGmail = "sistemagestionpermisos@gmail.com";
        String claveGmail = "sgpadmin";
        
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(emailTO));
        generateMailMessage.setSubject(emailSubject);
        generateMailMessage.setContent(emailBody, "text/html");
        
        Transport transport = getMailSession.getTransport("smtp");

        transport.connect("smtp.gmail.com", emailGmail, claveGmail);
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    
    }
    
}
