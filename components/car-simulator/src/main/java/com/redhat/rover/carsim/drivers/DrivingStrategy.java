package com.redhat.rover.carsim.drivers;

import java.util.Optional;
import java.util.function.Consumer;

import com.redhat.rover.carsim.CarEvent;
import com.redhat.rover.carsim.routes.Route;
import com.redhat.rover.carsim.routes.RoutePoint;

public interface DrivingStrategy {
	
	public boolean supports(Route route);

	void drive(Optional<RoutePoint> from, RoutePoint to, Consumer<CarEvent> consumer);

}
