// Заглушки — заменить на реальные значения (см. docs задачи 29-05-26-landing-mvp).

// TODO: реальный хэндл Telegram-бота и стартовый параметр инвайт-флоу.
export const BOT_INVITE_URL = 'https://t.me/pacemeup_bot?start=invite';

export type Plan = {
  name: string;
  price: string;
  period?: string;
  note: string;
  features: string[];
  cta: string;
  highlight?: boolean;
};

// Тарифы — драфт. Цены и лимиты не финальные.
export const PLANS: Plan[] = [
  {
    name: 'Free',
    price: '€0',
    note: 'Invite beta',
    features: [
      'One active goal',
      'Today’s plan with a reason',
      'Basic limiter snapshot',
      'Text check-ins',
      'Reactive Quiet coach',
      '7-day training memory',
    ],
    cta: 'Request an invite',
  },
  {
    name: 'Pro',
    price: '€3.9',
    period: '/мес',
    note: 'Draft price',
    highlight: true,
    features: [
      'Voice check-ins',
      'Proactive coach and all characters',
      'Full limiter radar and 4-week trends',
      'Calendar-aware planning',
      'Goal chapters and athlete memory',
      'Adaptation from HRV and life load',
    ],
    cta: 'Request an invite',
  },
];
