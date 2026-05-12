import { useEffect, useRef, useState } from "react";
import { haversine } from "@/lib/geo";

export type ArrivalStatus =
  | "idle"
  | "insecure"
  | "unsupported"
  | "requesting"
  | "tracking"
  | "arrived"
  | "denied"
  | "error";

export interface UseArrivalResult {
  status: ArrivalStatus;
  distance: number | null;
  arrived: boolean;
  start: () => void;
  stop: () => void;
  error: string | null;
}

const ARRIVAL_RADIUS_M = 50;

export function useArrival(target: { lat: number; lon: number } | null): UseArrivalResult {
  const [status, setStatus] = useState<ArrivalStatus>("idle");
  const [distance, setDistance] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);
  const watchIdRef = useRef<number | null>(null);
  const arrivedRef = useRef(false);

  const stop = () => {
    if (watchIdRef.current !== null && typeof navigator !== "undefined") {
      navigator.geolocation.clearWatch(watchIdRef.current);
      watchIdRef.current = null;
    }
  };

  const start = () => {
    setError(null);
    if (typeof window === "undefined") return;
    if (!window.isSecureContext) {
      setStatus("insecure");
      return;
    }
    if (!("geolocation" in navigator)) {
      setStatus("unsupported");
      return;
    }
    if (!target) return;
    setStatus("requesting");
    const id = navigator.geolocation.watchPosition(
      (pos) => {
        const d = haversine(pos.coords.latitude, pos.coords.longitude, target.lat, target.lon);
        setDistance(d);
        if (d <= ARRIVAL_RADIUS_M) {
          if (!arrivedRef.current) {
            arrivedRef.current = true;
            setStatus("arrived");
          }
        } else if (!arrivedRef.current) {
          setStatus("tracking");
        }
      },
      (err) => {
        if (err.code === err.PERMISSION_DENIED) setStatus("denied");
        else {
          setStatus("error");
          setError(err.message);
        }
      },
      { enableHighAccuracy: true, maximumAge: 5000, timeout: 15000 },
    );
    watchIdRef.current = id;
  };

  useEffect(() => () => stop(), []);

  return {
    status,
    distance,
    arrived: status === "arrived",
    start,
    stop,
    error,
  };
}

export const ARRIVAL_RADIUS = ARRIVAL_RADIUS_M;
