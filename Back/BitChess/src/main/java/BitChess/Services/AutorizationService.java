package BitChess.Services;

import org.jose4j.jwa.AlgorithmConstraints;
import org.jose4j.jwk.RsaJsonWebKey;
import org.jose4j.jwk.RsaJwkGenerator;
import org.jose4j.jws.AlgorithmIdentifiers;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.jwt.JwtClaims;
import org.jose4j.jwt.consumer.InvalidJwtException;
import org.jose4j.jwt.consumer.JwtConsumer;
import org.jose4j.jwt.consumer.JwtConsumerBuilder;
import org.jose4j.lang.JoseException;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 02-Jun-17.
 */

@Service
public class AutorizationService {
    static Integer EXPIRATION_MINUTES = 30;
    static RsaJsonWebKey rsaJsonWebKey;

    static {
        try {
            rsaJsonWebKey = RsaJwkGenerator.generateJwk(2048);
            rsaJsonWebKey.setKeyId("Bitchess Key");
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            System.out.println("   Generating JWK Key success.  ");
            System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        } catch (JoseException ex) {
            System.out.println("Error at generating JwkKey.");
            System.exit(-1);
        }
    }

    public AutorizationService() {
    }

    // -- not needed anymore
    public Boolean checkCredentials(ConcreteDatabaseService databaseService, String token) {
        try {
            Integer res = databaseService.checkToken(token);
            System.out.println("wtf");
            if (res == -1 || res == 0)
                return false;
            return true;
        } catch (SQLException sqlEx) {
            return false;
        }
    }

    public String generateToken(String username, String email) {
        try {
            JwtClaims claims = new JwtClaims();
            claims.setIssuer("bitchess.ro");
            claims.setExpirationTimeMinutesInTheFuture(EXPIRATION_MINUTES);
            claims.setGeneratedJwtId();
            claims.setIssuedAtToNow();
            claims.setNotBeforeMinutesInThePast(0);
            claims.setClaim("username", username);
            claims.setClaim("email", username);
            JsonWebSignature jws = new JsonWebSignature();
            jws.setPayload(claims.toJson());
            jws.setKey(rsaJsonWebKey.getPrivateKey());
            jws.setKeyIdHeaderValue(rsaJsonWebKey.getKeyId());
            jws.setAlgorithmHeaderValue(AlgorithmIdentifiers.RSA_USING_SHA256);
            String jwt = jws.getCompactSerialization();
            //System.out.println("JWT: " + jwt);
            return jwt;
        } catch (JoseException ex) {
            System.out.println("Error at generating JWT key! " + ex);
        }
        return null;
    }

    public Boolean checkCredentials(String token) {
        JwtConsumer jwtConsumer = new JwtConsumerBuilder()
                .setRequireExpirationTime()
                .setAllowedClockSkewInSeconds(30)
                .setExpectedIssuer("bitchess.ro")
                .setVerificationKey(rsaJsonWebKey.getKey())
                .setJwsAlgorithmConstraints(
                        new AlgorithmConstraints(AlgorithmConstraints.ConstraintType.WHITELIST,
                                AlgorithmIdentifiers.RSA_USING_SHA256))
                .build();
        try {
            JwtClaims jwtClaims = jwtConsumer.processToClaims(token);
            //System.out.println("JWT validation succeeded! " + jwtClaims);
            return true;
        } catch (InvalidJwtException e) {
            System.out.println("Invalid JWT! " + e);
            return false;
        }
    }
}
