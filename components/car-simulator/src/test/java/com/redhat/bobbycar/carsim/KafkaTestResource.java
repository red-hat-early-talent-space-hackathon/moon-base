package com.redhat.rover.carsim;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static com.github.tomakehurst.wiremock.client.WireMock.post;
import static com.github.tomakehurst.wiremock.client.WireMock.urlMatching;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.options;

import java.util.Collections;
import java.util.Map;

import com.github.tomakehurst.wiremock.WireMockServer;

import io.quarkus.test.common.QuarkusTestResourceLifecycleManager;

public class KafkaTestResource implements QuarkusTestResourceLifecycleManager {
	///
	
	
	private WireMockServer wireMockServer;
	
	@Override
	public Map<String, String> start() {

		wireMockServer = new WireMockServer(options().dynamicPort());
		wireMockServer.start(); 
		wireMockServer.stubFor(post(urlMatching("/topics/rover-gps")).willReturn(
				aResponse().withHeader("Content-Type", "application/json").withBody("")));

		return Collections.singletonMap("com.redhat.rover.carsim.kafka.url", wireMockServer.baseUrl());
	}

	@Override
	public void stop() {
		if (null != wireMockServer) {
			wireMockServer.stop();
		}
	}
}
