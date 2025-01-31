"""Convience functions for creating stations with with completed
dependency injection
"""

from ..coms.drivers import ComsDriver
from ..coms.strategies import SerialComsStrategy, SocketComsStrategy
from .groundstation import GroundStation
from .launchstation import LaunchStation


def create_socket_launch_station(
    host: str = "127.0.1.1", port: int = 5000
) -> LaunchStation:
    """Convinence function for creating a Launch Station
    that communicates using a socket connection
    """
    return LaunchStation(
        ComsDriver(SocketComsStrategy.accept_connection_at(host, port))
    )


def create_socket_ground_station(
    host: str = "127.0.1.1", port: int = 5000
) -> GroundStation:
    """Convinence function for creating a Ground Station
    that communicates using a socket connection
    """
    return GroundStation(ComsDriver(SocketComsStrategy.connect_to(host, port)))


def create_serial_launch_station(port: str, baudrate: int) -> LaunchStation:
    """Convinence function for creating a Launch Station
    that communicates using a serial port
    """
    return LaunchStation(ComsDriver(SerialComsStrategy.from_args(port, baudrate)))


def create_serial_ground_station(port: str, baudrate: int) -> GroundStation:
    """Convinence function for creating a Ground Station
    that communicates using a serial port
    """
    return GroundStation(ComsDriver(SerialComsStrategy.from_args(port, baudrate)))
