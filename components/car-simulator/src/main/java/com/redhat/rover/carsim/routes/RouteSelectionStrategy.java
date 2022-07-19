package com.redhat.rover.carsim.routes;

public interface RouteSelectionStrategy {

	Route selectRoute();
	Route selectRoute(int route);
	int routes();
}
