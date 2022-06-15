package com.redhat.rover.carsim.consumer;

import com.redhat.rover.carsim.consumer.model.ZoneChangeEvent;

public interface ZoneChangeListener {
	
	public void onZoneChange(ZoneChangeEvent event);
	
}
