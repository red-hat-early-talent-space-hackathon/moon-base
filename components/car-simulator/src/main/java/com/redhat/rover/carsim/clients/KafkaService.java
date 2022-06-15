package com.redhat.rover.carsim.clients;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import com.redhat.rover.carsim.clients.model.KafkaCarEvent;

@Path("/topics/rover-gps")
@RegisterRestClient(configKey = "kafka")
public interface KafkaService {

	@POST
	@Consumes("application/vnd.kafka.json.v2+json")
	@Produces("application/vnd.kafka.v2+json")
	@Path("")
	public void publishCarEvent(@QueryParam("user_key") String apiKey, KafkaCarEvent carEvent);
}
