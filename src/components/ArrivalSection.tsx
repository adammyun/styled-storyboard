import { useEffect, useRef } from "react";
import { motion, AnimatePresence } from "framer-motion";
import confetti from "canvas-confetti";
import { Lock, MapPin, Download, ShieldAlert } from "lucide-react";
import { useArrival, ARRIVAL_RADIUS } from "@/hooks/useArrival";
import { formatDistance } from "@/lib/geo";

interface Props {
  target: { lat: number; lon: number };
  goodsUrl: string | null;
  goodsType: string;
  placeName: string;
}

export default function ArrivalSection({ target, goodsUrl, goodsType, placeName }: Props) {
  const { status, distance, arrived, start } = useArrival(target);
  const firedRef = useRef(false);

  useEffect(() => {
    if (arrived && !firedRef.current) {
      firedRef.current = true;
      const burst = (origin: { x: number; y: number }) =>
        confetti({ particleCount: 90, spread: 75, origin, scalar: 0.9, ticks: 200 });
      burst({ x: 0.25, y: 0.6 });
      setTimeout(() => burst({ x: 0.75, y: 0.6 }), 180);
      setTimeout(() => burst({ x: 0.5, y: 0.4 }), 360);
    }
  }, [arrived]);

  const insecure = status === "insecure";

  return (
    <section className="border-t border-faint pt-12 mt-16">
      <p className="text-[10px] tracking-[0.3em] text-ink-light flex items-center gap-3 mb-4">
        ARRIVAL <span className="block w-7 h-px bg-accent-c" />
      </p>
      <h3 className="font-serif-kr text-2xl md:text-3xl text-ink mb-2">도착 확인 및 굿즈 받기</h3>
      <p className="text-[13px] text-ink-mid mb-6">
        목표 좌표 반경 {ARRIVAL_RADIUS}m 안에 들어오면 디지털 굿즈가 해금됩니다.
      </p>

      {!window.isSecureContext && (
        <div className="flex items-start gap-3 p-4 rounded-sm border border-faint bg-card-bg/60 mb-6">
          <ShieldAlert className="w-4 h-4 mt-0.5 text-accent-c shrink-0" />
          <p className="text-[12px] text-ink-mid leading-relaxed">
            GPS 위치 인증은 보안 연결(HTTPS) 환경에서만 동작합니다. 게시된 사이트에서 다시 시도해 주세요.
          </p>
        </div>
      )}

      <div className="flex flex-col md:flex-row gap-6 items-start">
        {/* Left: status / action */}
        <div className="flex-1 w-full">
          <div className="rounded-sm border border-faint bg-paper p-6">
            <div className="flex items-center gap-2 text-[10px] tracking-[0.2em] text-ink-light mb-3">
              <MapPin className="w-3 h-3" />
              <span>TARGET · {target.lat.toFixed(4)}, {target.lon.toFixed(4)}</span>
            </div>

            {status === "idle" && (
              <>
                <p className="font-serif-kr text-[17px] text-ink mb-5 leading-relaxed">
                  지금 {placeName}에 도착하셨다면 위치를 인증하고 굿즈를 받아보세요.
                </p>
                <button
                  onClick={start}
                  disabled={insecure}
                  className="text-[11px] tracking-[0.2em] uppercase px-5 py-2.5 rounded-full border border-ink text-ink hover:bg-ink hover:text-paper transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                >
                  위치 확인하기
                </button>
              </>
            )}

            {(status === "requesting" || status === "tracking") && (
              <>
                <p className="font-serif-kr text-[17px] text-ink mb-2 leading-relaxed">
                  아직 길 위에 있나요? 목적지에 도착하면 굿즈가 해금됩니다.
                </p>
                {distance !== null && (
                  <p className="text-[12px] text-ink-light tabular-nums">
                    현재 거리 · 약 {formatDistance(distance)}
                  </p>
                )}
                {status === "requesting" && (
                  <p className="text-[11px] text-ink-light mt-2">위치를 가져오는 중…</p>
                )}
              </>
            )}

            {status === "arrived" && (
              <p className="font-serif-kr text-[18px] text-ink leading-relaxed">
                도착을 확인했어요. 오른쪽에서 굿즈를 받아보세요.
              </p>
            )}

            {status === "denied" && (
              <p className="text-[13px] text-ink-mid">
                위치 권한이 거부되었어요. 브라우저 설정에서 위치 접근을 허용해 주세요.
              </p>
            )}
            {status === "unsupported" && (
              <p className="text-[13px] text-ink-mid">이 기기에서는 위치 정보를 사용할 수 없어요.</p>
            )}
            {status === "error" && (
              <p className="text-[13px] text-ink-mid">위치를 가져오지 못했어요. 잠시 후 다시 시도해 주세요.</p>
            )}
          </div>
        </div>

        {/* Right: goods */}
        <div className="w-full md:w-[300px] shrink-0">
          <div className="relative rounded-sm border border-faint overflow-hidden bg-card-bg aspect-[3/4]">
            <AnimatePresence>
              {arrived && goodsUrl ? (
                <motion.img
                  key="goods"
                  initial={{ opacity: 0, scale: 1.05 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.6, ease: [0.22, 1, 0.36, 1] }}
                  src={goodsUrl}
                  alt={`${placeName} 굿즈`}
                  className="absolute inset-0 w-full h-full object-cover"
                />
              ) : (
                <motion.div
                  key="locked"
                  initial={{ opacity: 1 }}
                  exit={{ opacity: 0 }}
                  className="absolute inset-0 flex flex-col items-center justify-center gap-3 text-ink-light"
                >
                  <Lock className="w-6 h-6" />
                  <p className="text-[10px] tracking-[0.25em] uppercase">Locked</p>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
          <div className="mt-3 flex items-center justify-between">
            <p className="text-[10px] tracking-[0.2em] uppercase text-ink-light">
              {goodsType === "stamp" ? "Stamp" : "Wallpaper"}
            </p>
            <a
              href={arrived && goodsUrl ? goodsUrl : undefined}
              download={arrived ? `${placeName}-goods` : undefined}
              target="_blank"
              rel="noreferrer"
              aria-disabled={!arrived}
              className={`inline-flex items-center gap-2 text-[11px] tracking-[0.18em] uppercase px-4 py-2 rounded-full border transition-colors ${
                arrived && goodsUrl
                  ? "border-ink text-ink hover:bg-ink hover:text-paper"
                  : "border-faint text-ink-light pointer-events-none opacity-50"
              }`}
            >
              <Download className="w-3 h-3" /> 다운로드
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
