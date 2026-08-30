export interface HealthResponse {
  status: 'ok';
  database: 'up' | 'down';
  timestamp: string;
}
