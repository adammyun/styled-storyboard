
create table public.paths (
  id text primary key,
  name text not null,
  region text not null,
  type text not null,
  latitude double precision not null,
  longitude double precision not null,
  cover_image text not null,
  content jsonb not null default '{}'::jsonb,
  goods_url text,
  goods_type text not null default 'wallpaper',
  created_at timestamptz not null default now()
);

alter table public.paths enable row level security;

create policy "paths are viewable by everyone"
  on public.paths for select
  using (true);

insert into public.paths (id, name, region, type, latitude, longitude, cover_image, goods_url, goods_type, content) values
('arch-samsan-alley','삼산동 주택가 골목','namgu','샛길',35.5384,129.3380,'arch-samsan-alley','https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1600','wallpaper',
  '{"story":"낮은 담장과 빨래줄이 길게 이어지는 삼산동의 좁은 골목. 낯선 사람의 발소리에도 고양이가 슬쩍 고개만 돌리고 다시 졸음에 빠지는, 그런 평일 오후의 풍경.","route":[{"step":"01","text":"삼산동 행정복지센터 앞에서 출발해 좁은 일방통행 골목으로 진입합니다."},{"step":"02","text":"세 번째 사거리에서 좌회전, 작은 슈퍼를 지나 계속 직진."},{"step":"03","text":"담쟁이가 우거진 파란 대문 앞에서 잠깐 멈춰서 사진 한 장."}],"tidbits":["골목 끝 작은 빵집은 오후 3시에 갓 구운 빵이 나옵니다.","비 오는 날엔 처마 아래 고양이가 모입니다."]}'::jsonb),
('arch-jangseongpo','장생포 고래문화마을','namgu','갓길',35.4936,129.3669,'arch-jangseongpo','https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1600','wallpaper',
  '{"story":"한때 고래잡이의 전진기지였던 장생포. 지금은 그 시간을 박제한 마을이 천천히 바닷바람에 색이 바래고 있어요.","route":[{"step":"01","text":"장생포 고래박물관 주차장에서 출발."},{"step":"02","text":"옛 마을 골목을 따라 천천히 언덕을 오릅니다."},{"step":"03","text":"전망대에서 항구를 한 번 내려다보고 다시 내려와요."}],"tidbits":["주말 오전엔 고래빵 노점이 열립니다.","마을 벽화는 5년 단위로 새로 그려져요."]}'::jsonb),
('arch-seonam-shortcut','선암호수공원 숏컷','namgu','지름길',35.5118,129.3168,'arch-seonam-shortcut','https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=1600','wallpaper',
  '{"story":"선암호수의 둘레길을 다 돌지 않아도 호수의 가장 예쁜 한 면을 볼 수 있는 25분짜리 숏컷.","route":[{"step":"01","text":"북쪽 주차장에서 호수쪽으로 내려갑니다."},{"step":"02","text":"데크길을 따라 동쪽 숲길로 들어서요."},{"step":"03","text":"중간 정자에서 호수를 한 번 보고 되돌아옵니다."}],"tidbits":["오리들이 사람을 안 무서워합니다.","해질 무렵 물안개가 가장 예뻐요."]}'::jsonb),
('arch-sinjeong-mural','신정동 벽화 골목','namgu','샛길',35.5360,129.3260,'arch-sinjeong-mural','https://images.unsplash.com/photo-1529245856630-f4853233d2ea?w=1600','wallpaper',
  '{"story":"오래된 주택가에 동네 사람들이 직접 그린 벽화가 골목 끝까지 이어집니다.","route":[{"step":"01","text":"신정시장 옆 골목 입구에서 시작."},{"step":"02","text":"벽화를 따라 천천히 좌측 언덕길로."},{"step":"03","text":"언덕 위 작은 공원에서 마무리."}],"tidbits":["그림은 매년 봄에 한 면씩 새로 그려져요."]}'::jsonb),
('arch-namgu-riverside','남구 강변 둘레길','namgu','갓길',35.5290,129.3450,'arch-namgu-riverside','https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1600','wallpaper',
  '{"story":"태화강 하구의 남쪽 둑길. 자전거 타는 사람과 산책하는 사람이 적당히 섞여 있어요.","route":[{"step":"01","text":"삼호교 남단에서 출발."},{"step":"02","text":"강을 오른쪽에 두고 계속 동쪽으로."},{"step":"03","text":"태화교 직전에서 다리 위로 올라가요."}],"tidbits":["철새 도래지 표지판이 곳곳에 있습니다."]}'::jsonb),
('arch-sinjeong-market','신정 시장 뒷길','namgu','지름길',35.5340,129.3290,'arch-sinjeong-market','https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?w=1600','wallpaper',
  '{"story":"시장 정문이 아닌 뒷길로 들어가면 장사 준비 중인 새벽의 시장을 볼 수 있어요.","route":[{"step":"01","text":"시장 후문 주차장에서 진입."},{"step":"02","text":"가운데 큰 통로 대신 왼쪽 좁은 길로."},{"step":"03","text":"건어물 골목을 지나 정문으로 빠져나옵니다."}],"tidbits":["새벽 6시쯤이 가장 활기차요."]}'::jsonb),
('arch-taehwa-reeds','태화강 둔치 억새밭','junggu','갓길',35.5610,129.3360,'arch-taehwa-reeds','https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=1600','wallpaper',
  '{"story":"가을이면 사람보다 키가 큰 억새가 일렁이는 태화강 둔치. 바람 소리만 들립니다.","route":[{"step":"01","text":"태화강 국가정원 동문에서 출발."},{"step":"02","text":"둔치쪽 데크길로 내려가요."},{"step":"03","text":"억새밭 한가운데 길을 따라 걷습니다."}],"tidbits":["10월 말~11월 초가 절정.","해질녘에 역광으로 보면 가장 아름다워요."]}'::jsonb),
('arch-seongnam-flower','성남동 꽃담 골목','junggu','샛길',35.5550,129.3270,'arch-seongnam-flower','https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=1600','wallpaper',
  '{"story":"꽃집 주인들이 가게 앞에 화분을 내놓아 골목 자체가 작은 정원이 된 길.","route":[{"step":"01","text":"성남동 옛 시청 사거리에서 시작."},{"step":"02","text":"꽃집들이 모인 골목을 따라 북쪽으로."},{"step":"03","text":"카페가 모인 광장에서 마무리."}],"tidbits":["봄에는 길에 떨어진 꽃잎으로 카펫이 깔립니다."]}'::jsonb),
('arch-hakseong-trail','학성공원 우회 산책로','junggu','지름길',35.5600,129.3450,'arch-hakseong-trail','https://images.unsplash.com/photo-1448375240586-882707db888b?w=1600','wallpaper',
  '{"story":"학성공원의 정상을 거치지 않고 둘레만 돌아 반대편 출구로 빠지는 빠른 길.","route":[{"step":"01","text":"공원 정문에서 좌측 산책로로."},{"step":"02","text":"중간 갈림길에서 계속 우측 둘레길."},{"step":"03","text":"북문으로 빠져나옵니다."}],"tidbits":["여름엔 매미 소리가 정말 큽니다."]}'::jsonb),
('arch-jungang-market','중앙시장 뒷골목','junggu','샛길',35.5580,129.3330,'arch-jungang-market','https://images.unsplash.com/photo-1542838132-92c53300491e?w=1600','wallpaper',
  '{"story":"중앙시장 뒤쪽으로 돌아가면 오래된 식당과 작은 잡화점이 모여 있는 좁은 골목이 나옵니다.","route":[{"step":"01","text":"중앙시장 정문에서 우측으로 돌아 후문으로."},{"step":"02","text":"좁은 골목 안쪽 식당가를 지나요."},{"step":"03","text":"공구 거리에서 마무리."}],"tidbits":["오래된 분식집은 평일 11시에 가장 한가해요."]}'::jsonb),
('arch-taehwa-bridge','태화교 다리 산책길','junggu','갓길',35.5570,129.3360,'arch-taehwa-bridge','https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=1600','wallpaper',
  '{"story":"다리 위에서 강을 한 번에 내려다볼 수 있는 코스. 야경이 특히 좋아요.","route":[{"step":"01","text":"태화교 남단에서 출발."},{"step":"02","text":"다리 위 보행자 통로를 천천히 건넙니다."},{"step":"03","text":"북단에서 둔치로 내려가요."}],"tidbits":["밤에는 다리 조명이 색깔별로 바뀌어요."]}'::jsonb),
('arch-hakseong-ridge','학성 능선 지름길','junggu','지름길',35.5615,129.3470,'arch-hakseong-ridge','https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?w=1600','wallpaper',
  '{"story":"학성공원 능선을 따라 빠르게 가로지르는 길. 짧지만 약간의 오르막이 있어요.","route":[{"step":"01","text":"동문에서 능선 진입로로."},{"step":"02","text":"정상 표지석을 지나 계속 직진."},{"step":"03","text":"서문으로 빠져나옵니다."}],"tidbits":["정상에서 시내 전체가 보여요."]}'::jsonb);
