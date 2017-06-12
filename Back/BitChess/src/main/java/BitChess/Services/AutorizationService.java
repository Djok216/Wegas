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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 02-Jun-17.
 */

@Service
public class AutorizationService {
    @Autowired
    ConcreteDatabaseService databaseService;

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
            return databaseService.checkToken(token);
        } catch (SQLException sqlEx) {
            return false;
        }
    }

    public String generateToken(String username, String email) {
        try {
            JwtClaims claims = new JwtClaims();
            claims.setIssuer("www.bitchess.ro");
            claims.setExpirationTimeMinutesInTheFuture(EXPIRATION_MINUTES);
            claims.setGeneratedJwtId();
            claims.setIssuedAtToNow();
            claims.setNotBeforeMinutesInThePast(0);
            claims.setClaim("username", username);
            claims.setClaim("email", email);
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
                .setExpectedIssuer("www.bitchess.ro")
                .setVerificationKey(rsaJsonWebKey.getKey())
                .setJwsAlgorithmConstraints(
                        new AlgorithmConstraints(AlgorithmConstraints.ConstraintType.WHITELIST,
                                AlgorithmIdentifiers.RSA_USING_SHA256))
                .build();
        try {
            JwtClaims jwtClaims = jwtConsumer.processToClaims(token);
            Boolean result = false;
            try {
                result = databaseService.checkToken(token);
            } catch (SQLException sqlEx) {
                System.out.println("Token does not exist in database! " + sqlEx.getMessage());
                return false;
            }
            //System.out.println("JWT validation succeeded! " + jwtClaims);
            return result;
        } catch (InvalidJwtException e) {
            System.out.println("Invalid JWT! " + e);
            return false;
        }
    }
}
