package com.redhat.rover.carsim.cars;

import com.redhat.rover.carsim.routes.RoutePoint;

public interface Engine extends Runnable{

	EngineData currentData();

	TimedEngine nextRoutePoint(RoutePoint next);
	
	void stop();

	EngineConfiguration getEngineConfiguration();
}
