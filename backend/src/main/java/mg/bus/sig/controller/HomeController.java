package mg.bus.sig.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {
    @GetMapping(value = "/", produces = MediaType.TEXT_HTML_VALUE)
    public String home() {
        return """
                <!doctype html>
                <html lang="fr">
                <head>
                    <meta charset="utf-8">
                    <title>Bus SIG API</title>
                    <style>
                        body { font-family: system-ui, sans-serif; margin: 40px; line-height: 1.5; }
                        a { color: #0f766e; }
                    </style>
                </head>
                <body>
                    <h1>Bus SIG API</h1>
                    <p>Le backend fonctionne.</p>
                    <ul>
                        <li><a href="/api/trajets">/api/trajets</a></li>
                        <li><a href="/api/lignes">/api/lignes</a></li>
                        <li><a href="/api/arrets">/api/arrets</a></li>
                        <li><a href="/api/bus">/api/bus</a></li>
                    </ul>
                    <p>Interface carte: <a href="http://localhost:5173">http://localhost:5173</a></p>
                </body>
                </html>
                """;
    }
}
